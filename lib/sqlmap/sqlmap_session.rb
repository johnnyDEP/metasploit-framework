module Sqlmap
  class Session
    def initialize(host, port = 8775)
      @host = host
      @port = port
    end

    def get(uri, headers = nil, params = nil)
      c = Rex::Proto::Http::Client.new(@host, @port)
      args = {
        'uri' => uri
      }

      args['headers'] = headers if headers
      args['vars_get'] = params if params
      res = c.request_cgi(args)
      res = c.send_recv(res)
      return res
    end

    def post(uri, headers = nil, data = nil, originator_args = nil)
      c = Rex::Proto::Http::Client.new(@host, @port)
      args = {
        'uri' => uri,
        'method' => 'POST'
      }

      args.merge!(originator_args) if originator_args

      args['headers'] = headers if headers
      args['data'] = data if data
      res = c.request_cgi(args)
      res = c.send_recv(res)
      return res
    end
  end
end
