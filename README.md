📧 ReachInbox – Full-stack Email Job Scheduler

This project is a production-grade email scheduling system built as part of the ReachInbox Software Development Intern assignment.

The system demonstrates how large-scale email platforms schedule, throttle, and reliably send emails using queues instead of cron jobs.

🚀 Features Overview
Backend

Email scheduling via REST APIs

Delayed email jobs using BullMQ + Redis

Persistent storage using PostgreSQL

Email sending via Ethereal Email (SMTP)

Worker concurrency control

Hourly rate-limiting (Redis-safe)

Fault-tolerant (jobs survive server restarts)

No cron jobs used

Frontend

Google OAuth login

Dashboard to view:

Scheduled emails

Sent emails

Compose email interface

CSV/email list upload

Configurable delay & hourly limits

Clean UI following provided Figma

🏗️ Architecture Overview
Client (React Dashboard)
        |
        v
Backend API (Express + TypeScript)
        |
        v
PostgreSQL  ←→  BullMQ Queue  ←→  Redis
                        |
                        v
                  Worker Process
                        |
                        v
                Ethereal SMTP

Key Design Decisions

BullMQ delayed jobs are used for scheduling (no cron)

Redis-backed queues ensure persistence

Database maintains source-of-truth for email state

Separate worker process handles email sending

Rate limiting is enforced using Redis so it’s safe across restarts and multiple workers

⚙️ Tech Stack
Backend

Node.js

TypeScript

Express.js

BullMQ

Redis

PostgreSQL

Nodemailer

Ethereal Email

Frontend

React.js

TypeScript

Tailwind CSS

🧠 Scheduling Logic

User schedules an email

Email metadata is saved in the database with status scheduled

A BullMQ delayed job is created based on sendAt

Worker consumes job at correct time

Email is sent via SMTP

Status updated to sent or failed

🔄 Persistence & Restart Handling

BullMQ stores jobs in Redis

PostgreSQL stores email metadata

On server/worker restart:

Pending jobs are restored automatically

No duplicate emails are sent

Scheduling continues correctly

🚦 Rate Limiting & Concurrency
Concurrency

Worker concurrency is configurable via environment variables

Hourly Rate Limit

Maximum emails per hour is configurable

Implemented using Redis-backed BullMQ limiter

Jobs are delayed, not dropped, when the limit is reached

Example config:

MAX_EMAILS_PER_HOUR=100
WORKER_CONCURRENCY=5

📦 Backend Setup Instructions
1️⃣ Clone Repository
git clone <private-repo-url>
cd backend

2️⃣ Install Dependencies
npm install

3️⃣ Environment Variables

Create a .env file:

REDIS_URL=redis://localhost:6379
DATABASE_URL=postgres://user:password@localhost:5432/reachinbox
SMTP_HOST=smtp.ethereal.email
SMTP_PORT=587
SMTP_USER=your_ethereal_user
SMTP_PASS=your_ethereal_pass
MAX_EMAILS_PER_HOUR=100
WORKER_CONCURRENCY=5

4️⃣ Database Setup
CREATE TABLE emails (
  id SERIAL PRIMARY KEY,
  recipient TEXT,
  subject TEXT,
  body TEXT,
  send_at TIMESTAMP,
  sent_at TIMESTAMP,
  status TEXT
);

5️⃣ Start Services
npm run dev     # Start API
npm run worker  # Start Worker

🖥️ Frontend Setup Instructions
cd frontend
npm install
npm run dev

🧪 Demo Scenarios

Schedule multiple emails for the same time

Restart backend & worker

Observe emails sending at correct schedule

Verify rate-limit throttling behavior

📝 Assumptions & Trade-offs

Ethereal Email used for safe testing

Rate limiting implemented globally (can be extended per sender)

Frontend focuses on core flows over advanced analytics



🧑‍💻 Author

Simar
Software Development Intern Applicant
ReachInbox Assignment
