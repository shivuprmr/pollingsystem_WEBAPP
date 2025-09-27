# 🚀 Installation & Setup Guide

## Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js** (v16 or higher) - [Download here](https://nodejs.org/)
- **MongoDB** (v4.4 or higher) - [Installation guide](https://docs.mongodb.com/manual/installation/)
- **Git** - [Download here](https://git-scm.com/)

## 🛠️ Quick Setup

### 1. Install Dependencies

```bash
# Navigate to the project directory
cd polling-system

# Install root dependencies (for concurrently)
npm install

# Install all dependencies (backend + frontend)
npm run install:all
```

### 2. Environment Configuration

#### Backend Environment
Create `backend/.env` file:

```env
# Server Configuration
PORT=3001
NODE_ENV=development

# Database
MONGODB_URI=mongodb://localhost:27017/polling-system

# JWT Configuration
JWT_SECRET=your-super-secret-jwt-key-change-this-in-production
JWT_EXPIRES_IN=7d

# Email Configuration (Gmail example)
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USER=your-email@gmail.com
EMAIL_PASS=your-app-password

# Frontend URL
FRONTEND_URL=http://localhost:5173

# Rate Limiting
RATE_LIMIT_WINDOW_MS=900000
RATE_LIMIT_MAX_REQUESTS=100
```

#### Frontend Environment
Create `frontend/.env` file:

```env
VITE_API_URL=http://localhost:3001
VITE_WS_URL=http://localhost:3001
```

### 3. Email Setup (Gmail)

1. Enable 2-factor authentication on your Gmail account
2. Generate an App Password:
   - Go to Google Account settings
   - Security → 2-Step Verification → App passwords
   - Generate password for "Mail"
   - Use this password in `EMAIL_PASS`

### 4. Start the Application

```bash
# Start both backend and frontend (recommended)
npm run dev

# OR start individually:
# Backend only
npm run dev:backend

# Frontend only  
npm run dev:frontend
```

### 5. Access the Application

- **Frontend**: http://localhost:5173
- **Backend API**: http://localhost:3001
- **API Health Check**: http://localhost:3001/health

## 🔧 Individual Setup

### Backend Setup

```bash
cd backend

# Install dependencies
npm install

# Copy environment file
cp .env.example .env

# Edit .env with your configuration
nano .env  # or use your preferred editor

# Start development server
npm run dev

# Or build and start production
npm run build
npm start
```

### Frontend Setup

```bash
cd frontend

# Install dependencies
npm install

# Copy environment file
cp .env.example .env

# Edit .env with your configuration
nano .env  # or use your preferred editor

# Start development server
npm run dev

# Or build for production
npm run build
```

## 📊 Database Setup

### Local MongoDB

1. **Install MongoDB** following the official guide
2. **Start MongoDB service**:
   ```bash
   # On macOS with Homebrew
   brew services start mongodb-community

   # On Ubuntu/Debian
   sudo systemctl start mongod

   # On Windows
   net start MongoDB
   ```

3. **Create database** (optional - will be created automatically):
   ```bash
   mongosh
   use polling-system
   ```

### MongoDB Atlas (Cloud)

1. Create account at [MongoDB Atlas](https://www.mongodb.com/atlas)
2. Create a new cluster
3. Get connection string
4. Update `MONGODB_URI` in backend/.env

## 🎯 First Time Setup

### 1. Create Admin Account

1. Start the application
2. Register the first user - they'll automatically become admin
3. Verify email address
4. Access admin dashboard at `/admin`

### 2. Test the System

1. **Create a poll** (as admin)
2. **Register additional users** (students)
3. **Vote on polls** (as students)
4. **View real-time results**

## 🚨 Troubleshooting

### Common Issues

#### Port Already in Use
```bash
# Check what's using the port
lsof -i :3001  # or :5173

# Kill the process
kill -9 <PID>
```

#### MongoDB Connection Error
```bash
# Check MongoDB status
mongosh --eval "db.stats()"

# Restart MongoDB
# macOS: brew services restart mongodb-community
# Ubuntu: sudo systemctl restart mongod
```

#### Email Not Sending
- Verify Gmail App Password is correct
- Check firewall settings
- Ensure 2-factor authentication is enabled
- Try different SMTP provider

#### Build Errors
```bash
# Clear node_modules and reinstall
rm -rf node_modules package-lock.json
npm install

# Clear build cache
rm -rf dist .vite
```

## 🔒 Security Checklist

### For Production Deployment

- [ ] Change `JWT_SECRET` to a strong random string
- [ ] Use environment variables for all secrets
- [ ] Set up HTTPS/SSL certificates
- [ ] Configure proper CORS settings
- [ ] Set up rate limiting
- [ ] Use a production MongoDB instance
- [ ] Set `NODE_ENV=production`
- [ ] Configure proper logging
- [ ] Set up monitoring and alerts

## 📝 Scripts Reference

### Root Package Scripts
```bash
npm run dev              # Start both backend and frontend
npm run dev:backend      # Start backend only
npm run dev:frontend     # Start frontend only
npm run build           # Build frontend for production
npm start               # Start production backend
npm run install:all     # Install all dependencies
```

### Backend Scripts
```bash
npm run dev             # Start development server with nodemon
npm run build           # Compile TypeScript to JavaScript
npm start               # Start production server
npm test                # Run tests
npm run test:watch      # Run tests in watch mode
```

### Frontend Scripts
```bash
npm run dev             # Start development server with Vite
npm run build           # Build for production
npm run preview         # Preview production build
npm run lint            # Run ESLint
```

## 🌐 Deployment

### Vercel (Frontend)
1. Connect GitHub repository
2. Set build command: `npm run build`
3. Set environment variables in Vercel dashboard

### Railway/Heroku (Backend)
1. Connect GitHub repository
2. Set environment variables
3. Ensure MongoDB connection string is correct

### Docker (Optional)
Docker configurations can be added for containerized deployment.

---

## 🆘 Need Help?

If you encounter issues:

1. **Check the logs** in terminal
2. **Verify environment variables** are set correctly
3. **Ensure MongoDB is running**
4. **Check port availability**
5. **Review the troubleshooting section**

For additional support, check the project documentation or create an issue in the repository.