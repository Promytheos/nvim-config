return {
  adapters = {
    java = function(callback)
      callback({
        type = 'server',
        host = '127.0.0.1',
        port = 5005,
      })
    end

  },
  configurations = {
    java = {
      {
        type = 'java',
        request = 'attach',
        name = "Debug (Attach)",
        hostName = "127.0.0.1",
        port = 5005,
      },
      {
        type = 'java',
        request = 'launch',
        name = "Debug (Launch)",
        hostName = "127.0.0.1",
        port = 5005,
      },
    },
  },
}
