class CorsMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    if env["REQUEST_METHOD"] == "OPTIONS"
      # Preflight request, respond with CORS headers
      return cors_headers
    end

    @app.call(env).tap do |status, headers, body|
      headers.merge!(cors_headers)
    end
  end

  private

  def cors_headers
    {
      "Access-Control-Allow-Origin" => "http://localhost:3000",
      "Access-Control-Allow-Methods" => "GET, POST, PUT, DELETE, OPTIONS",
      "Access-Control-Allow-Headers" => "Content-Type, Authorization",
      "Access-Control-Expose-Headers" => "Authorization",
      "Access-Control-Max-Age" => "1728000",
      "Access-Control-Allow-Credentials" => "true"
    }
  end
end
