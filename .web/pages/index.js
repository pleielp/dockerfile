import { useEffect, useRef, useState } from "react";

import { useRouter } from "next/router";

import { E, connect, updateState } from "/utils/state";

import "focus-visible/dist/focus-visible";

import {
  Box,
  Center,
  Code,
  Heading,
  Link,
  VStack,
  useColorMode,
} from "@chakra-ui/react";

import NextLink from "next/link";

import NextHead from "next/head";

const EVENT = "ws://localhost:8000/event";

export default function Component() {
  const [state, setState] = useState({ events: [{ name: "state.hydrate" }] });

  const [result, setResult] = useState({
    state: null,
    events: [],
    processing: false,
  });

  const router = useRouter();

  const socket = useRef(null);

  const { isReady } = router;

  const { colorMode, toggleColorMode } = useColorMode();

  const Event = (events) =>
    setState({
      ...state,

      events: [...state.events, ...events],
    });

  useEffect(() => {
    if (!isReady) {
      return;
    }

    const reconnectSocket = () => {
      socket.current.reconnect();
    };

    if (typeof socket.current !== "undefined") {
      if (!socket.current) {
        window.addEventListener("focus", reconnectSocket);

        connect(socket, state, setState, result, setResult, router, EVENT);
      }
    }

    const update = async () => {
      if (result.state != null) {
        setState({
          ...result.state,

          events: [...state.events, ...result.events],
        });

        setResult({
          state: null,

          events: [],

          processing: false,
        });
      }

      await updateState(
        state,
        setState,
        result,
        setResult,
        router,
        socket.current
      );
    };

    update();
  });

  return (
    <Center sx={{ paddingTop: "10%" }}>
      <VStack spacing="1.5em" sx={{ fontSize: "2em" }}>
        <Heading sx={{ fontSize: "2em" }}>{`Welcome to Pynecone!`}</Heading>

        <Box>
          {`Get started by editing `}

          <Code
            sx={{ fontSize: "1em" }}
          >{`web_frontend_pynecone/web_frontend_pynecone.py`}</Code>
        </Box>

        <NextLink
          href="https://pynecone.io/docs/getting-started/introduction"
          passHref={true}
        >
          <Link
            sx={{
              border: "0.1em solid",
              padding: "0.5em",
              borderRadius: "0.5em",
              _hover: { color: "rgb(107,99,246)" },
            }}
          >{`Check out our docs!`}</Link>
        </NextLink>
      </VStack>

      <NextHead>
        <title>{`Pynecone App`}</title>

        <meta name="description" content="A Pynecone app." />

        <meta property="og:image" content="favicon.ico" />
      </NextHead>
    </Center>
  );
}
