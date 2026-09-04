# Deployment Guide

This guide explains how to deploy the Bangla-Prompt (prompts.chat) application successfully.

## 🔧 Build Issue Fixed

The application now supports building without a real database connection during the build phase. This was fixed by:

1. ✅ Adding `.env.build` with a dummy `DATABASE_URL` for Prisma schema generation
2. ✅ Creating `vercel.json` for Vercel deployment configuration
3. ✅ Adding `build.sh` script for manual deployment setups
4. ✅ Creating GitHub Actions CI/CD workflow

## 🚀 Quick Start

### Option 1: Vercel Deployment (Recommended)

Vercel is the easiest way to deploy Next.js applications.

**Steps:**
1. Push your code to GitHub
2. Go to [vercel.com](https://vercel.com)
3. Click "New Project" → Select your repository
4. In Environment Variables, add:
   ```
   DATABASE_URL=postgresql://[user]:[password]@[host]:[port]/[database]
   NEXTAUTH_SECRET=your-secret-key-here
   NEXTAUTH_URL=https://your-domain.com
   ```
5. Click Deploy!

The `vercel.json` configuration will automatically use the environment variables you set.

### Option 2: GitHub Actions (Automated Testing)

The workflow automatically runs on every push to `main` or `develop` branches.

Check the status:
- Go to your repository → Actions tab
- Click the latest workflow run

The workflow:
- ✅ Sets up Node.js 24.x
- ✅ Installs dependencies
- ✅ Builds the application with dummy DATABASE_URL
- ✅ Runs linting and type checking

### Option 3: Manual Deployment (Any Platform)

For Netlify, Railway, Render, or other platforms:

**1. Set Environment Variables:**
```bash
DATABASE_URL=postgresql://[user]:[password]@[host]:[port]/[database]
NEXTAUTH_SECRET=your-secret-key
NEXTAUTH_URL=https://your-domain.com
```

**2. Use the build script:**
```bash
./build.sh
```

Or add as build command:
```
./build.sh
```

**3. Start command:**
```bash
npm run start
```

## 🗄️ Database Setup

### Recommended: Neon (Free Tier Available)

Neon is a PostgreSQL-as-a-Service platform with a generous free tier.

1. Go to [neon.tech](https://neon.tech)
2. Sign up and create a new project
3. Copy the connection string (it will be your `DATABASE_URL`)
4. Add to your deployment platform's environment variables

### Alternative: Supabase

1. Go to [supabase.com](https://supabase.com)
2. Create a new project
3. Copy the database URL from the connection string
4. Use as `DATABASE_URL`

### Local Development

For local development, use:
```bash
DATABASE_URL="postgresql://postgres:postgres@localhost:5432/prompts_chat?schema=public"
```

Then run:
```bash
npm install
npm run db:setup  # Sets up database with seed data
npm run dev
```

## 🔑 Environment Variables Reference

| Variable | Description | Required | Example |
|----------|-------------|----------|---------|
| `DATABASE_URL` | PostgreSQL connection string | ✅ Yes | `postgresql://user:pass@host:5432/db` |
| `DIRECT_URL` | Direct database URL (for pooling) | ❌ No | Same as DATABASE_URL |
| `NEXTAUTH_SECRET` | Auth session encryption key | ✅ Yes | Generate: `openssl rand -base64 32` |
| `NEXTAUTH_URL` | Application URL | ✅ Yes | `https://yourdomain.com` |
| `OPENAI_API_KEY` | For AI features (optional) | ❌ No | Your OpenAI key |
| `GOOGLE_CLIENT_ID` | Google OAuth (optional) | ❌ No | From Google Console |
| `GOOGLE_CLIENT_SECRET` | Google OAuth (optional) | ❌ No | From Google Console |
| `GITHUB_CLIENT_ID` | GitHub OAuth (optional) | ❌ No | From GitHub Settings |
| `GITHUB_CLIENT_SECRET` | GitHub OAuth (optional) | ❌ No | From GitHub Settings |

## 📋 Pre-Deployment Checklist

- [ ] Database provisioned and `DATABASE_URL` set
- [ ] `NEXTAUTH_SECRET` generated (use: `openssl rand -base64 32`)
- [ ] `NEXTAUTH_URL` set to your domain
- [ ] All environment variables added to deployment platform
- [ ] Latest code pushed to GitHub
- [ ] GitHub Actions workflow completed successfully

## 🛠️ Troubleshooting

### Build Fails with "Missing DATABASE_URL"

**Solution:** The dummy DATABASE_URL should be provided automatically. If still failing:
1. Check `.env.build` exists in repository root
2. Set `DATABASE_URL` in your deployment platform
3. Ensure Node.js version is 24.x

### Database Connection Errors

**Check:**
- DATABASE_URL is correct and accessible
- Your IP is whitelisted (for Neon/Supabase)
- SSL is required (add `?sslmode=require` to URL if needed)

### NextAuth Errors

**Common issues:**
- `NEXTAUTH_SECRET` not set → Generate one
- `NEXTAUTH_URL` doesn't match callback URL → Update in auth provider settings
- OAuth provider not configured → Use email/password or add OAuth keys

## 📚 Additional Resources

- [Next.js Deployment Docs](https://nextjs.org/docs/deployment)
- [Vercel Documentation](https://vercel.com/docs)
- [Prisma Deployment Guide](https://www.prisma.io/docs/orm/overview/deployments)
- [NextAuth.js Docs](https://next-auth.js.org)
- [prompts.chat Repository](https://github.com/f/prompts.chat)

## 🆘 Getting Help

If you encounter issues:

1. Check the GitHub Actions logs for build errors
2. Review the [SELF-HOSTING.md](SELF-HOSTING.md) guide
3. Check Docker setup in [DOCKER.md](DOCKER.md)
4. Open an issue on the [upstream repository](https://github.com/f/prompts.chat/issues)

---

**Happy Deploying! 🚀**
