const nodemailer = require('nodemailer');
const fs = require('fs');
const path = require('path');

// Build the full path to report.html in the current directory
const reportPath = path.join(__dirname, 'report.html');

if (!fs.existsSync(reportPath)) {
  console.error("❌ Report file not found at:", reportPath);
  process.exit(1);
}

let transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: 'harishsanjay0929@gmail.com',
    pass: 'hlih fauh gquv oidd' // Use your app password
  }
});

let mailOptions = {
  from: 'harishsanjay0929@gmail.com',
  to: 'harishsanjaya0929@gmail.com',
  subject: 'Span Technology Services API Newman Automated Test Report',
  text: 'Dear User'
  attachments: [
    {
      filename: 'report.html',
      path: reportPath
    }
  ]
};

console.log("📤 Sending email with report...");
transporter.sendMail(mailOptions, (error, info) => {
  if (error) {
    console.error('❌ Error sending email:', error);
    process.exit(1);
  } else {
    console.log('✅ Email sent successfully:', info.response);
    process.exit(0);
  }
});
