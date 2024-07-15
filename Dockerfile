# Stage 1: Build stage
# Use a specific version of Ruby as base
ARG RUBY_VERSION=3.1.4
FROM ruby:$RUBY_VERSION-slim as build

# Rails app lives here
WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development test"

# Install build dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libsqlite3-dev libvips pkg-config

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install --jobs=$(nproc) --retry=3

# Copy application code
COPY . .

# Precompile assets
RUN bundle exec rails assets:precompile

# Stage 2: Final production stage
FROM ruby:$RUBY_VERSION-slim as production

# Rails app lives here
WORKDIR /rails

# Install runtime dependencies
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y curl libsqlite3-0 libvips && \
    rm -rf /var/lib/apt/lists/*

# Copy built artifacts from build stage
COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Set environment variables
ENV RAILS_ENV="production" \
    RAILS_MASTER_KEY="<your_master_key_value_here>"

# Create a non-root user for running the application
RUN useradd rails --create-home --shell /bin/bash && \
    chown -R rails:rails db log storage tmp

# Switch to the non-root user
USER rails

# Entrypoint prepares the database
ENTRYPOINT ["./bin/docker-entrypoint"]

# Expose port for Rails server
EXPOSE 3001

# Command to start the Rails server
CMD ["./bin/rails", "server"]
