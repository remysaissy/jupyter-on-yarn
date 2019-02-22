from notebook.auth import passwd

hash_passwd = passwd()

with open('base/jupyter_notebook_config.py', 'r') as fd:
    config = fd.readlines()


index = next((index for index, line in enumerate(config) if line.startswith("c.NotebookApp.password")))

config[index] = f"c.NotebookApp.password = '{hash_passwd}'"

with open('base/jupyter_notebook_config.py', 'w') as fd:
    fd.writelines(config)
