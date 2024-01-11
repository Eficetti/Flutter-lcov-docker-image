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
ENV PATH="$PATH:/flutter/bin:/flutter/bin/cache/dart-sdk/bin:/root/.pub-cache/bin"
ENV PUB_HOSTED_URL=https://pub.flutter-io.cn
ENV FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

# Clone the Flutter SDK
RUN git clone https://github.com/flutter/flutter.git /flutter

# Change ownership of the /flutter directory
RUN chown -R developer:developer /flutter

# Change to non-root user
USER developer

# Upgrade Flutter SDK
RUN flutter channel stable
RUN flutter upgrade

# Run flutter doctor
RUN flutter doctor

# Print Flutter version
RUN flutter --version


# Activate remove_from_coverage
RUN dart pub global activate remove_from_coverage

# Verify lcov installation
RUN lcov --version

