module Genability
  # Custom error class for rescuing from all Genability errors
  class Error < StandardError; end

  # Raised when Genability returns the HTTP status code 400
  class BadRequest < Error; end

  # Raised when Genability returns the HTTP status code 403
  class Forbidden < Error; end

  # Raised when Genability returns the HTTP status code 404
  class NotFound < Error; end

  # Raised when Genability returns the HTTP status code 500
  class ServerError < Error; end

  # Raised when Genability returns the HTTP status code 503
  class ServiceUnavailable < Error; end

end

