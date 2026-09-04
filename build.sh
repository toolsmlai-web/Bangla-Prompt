#!/bin/bash
# Build script that sets up environment and runs the Next.js build

# Load build-time environment variables if they exist
if [ -f .env.build ]; then
  export $(cat .env.build | grep -v '^#' | xargs)
fi

# Set a default DATABASE_URL if not already set
# This ensures Prisma can generate the client during the build
export DATABASE_URL="${DATABASE_URL:-postgresql://user:password@localhost:5432/dummy?schema=public}"

# Run the build command from package.json
npm run build
