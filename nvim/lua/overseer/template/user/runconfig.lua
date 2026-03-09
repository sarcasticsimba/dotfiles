return {
  name = "Run bash command",
  builder = function(params)
    return {
      cmd = { "bash", "-c", params.cmd },
    }
  end,
  params = {
    cmd = {
      type = "string",
      name = "Command",
      desc = "Bash command to run",
    },
  },
}
