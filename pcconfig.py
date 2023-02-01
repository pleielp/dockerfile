import pynecone as pc


config = pc.Config(
    app_name="app",
    bun_path="/app/.bun/bin/bun",
    db_url="sqlite:///pynecone.db",
    env=pc.Env.DEV,
)
