const express = require('express')
const { spawn } = require('child_process')
const app = express()
const port = 3000

app.use(express.json())

app.post('/compress', (req, res) => {
  const python = spawn('python3', [
    'compress_prompt.py',
    JSON.stringify(req.body),
  ])

  let scriptOutput = ''

  python.stdout.on('data', (data) => {
    scriptOutput += data.toString()
  })

  python.stderr.on('data', (data) => {
    console.error(`stderr: ${data}`)
  })

  python.on('close', (code) => {
    console.log(`child process exited with code ${code}`)
    res.send(scriptOutput)
  })
})

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`)
})
