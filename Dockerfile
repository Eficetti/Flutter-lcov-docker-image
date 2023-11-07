# Start from a base image
FROM debian:latest

# Create a non-root user
RUN useradd -ms /bin/bash developer

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    unzip \
    xz-utils \
    zlib1g-dev \
    lib32stdc++6 \
    lcov

# Set your environment variables
ENV PATH="$PATH:/flutter/bin"

# Clone the Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /flutter

# Change ownership of the /flutter directory
RUN chown -R developer:developer /flutter

# Change to non-root user
USER developer

# Run flutter doctor
RUN flutter doctor

# Upgrade Flutter SDK
RUN flutter channel stable
RUN flutter upgrade

# Activate remove_from_coverage
RUN dart pub global activate remove_from_coverage

# Verify lcov installation
RUN lcov --version