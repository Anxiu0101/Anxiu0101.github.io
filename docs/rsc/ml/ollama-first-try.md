# Ollama First Try

## Get Start

```shell
Welcome to Ollama!

Run your first model:

        ollama run llama2

PS C:\Windows\system32> ollama run llama2
pulling manifest
pulling 8934d96d3f08... 100% ▕████████████████████████████████████████████████████████▏ 3.8 GB
pulling 8c17c2ebb0ea... 100% ▕████████████████████████████████████████████████████████▏ 7.0 KB
pulling 7c23fb36d801... 100% ▕████████████████████████████████████████████████████████▏ 4.8 KB
pulling 2e0493f67d0c... 100% ▕████████████████████████████████████████████████████████▏   59 B
pulling fa304d675061... 100% ▕████████████████████████████████████████████████████████▏   91 B
pulling 42ba7f8a01dd... 100% ▕████████████████████████████████████████████████████████▏  557 B
verifying sha256 digest
writing manifest
removing any unused layers
success
>>>
```



```python
>>> /?
Available Commands:
  /set            Set session variables
  /show           Show model information
  /load <model>   Load a session or model
  /save <model>   Save your current session
  /bye            Exit
  /?, /help       Help for a command
  /? shortcuts    Help for keyboard shortcuts

Use """ to begin a multi-line message.
```



```python
>>> /show info
Model details:
Family              llama
Parameter Size      7B
Quantization Level  Q4_0
```





```python
>>> /? shortcuts
Available keyboard shortcuts:
  Ctrl + a            Move to the beginning of the line (Home)
  Ctrl + e            Move to the end of the line (End)
   Alt + b            Move back (left) one word
   Alt + f            Move forward (right) one word
  Ctrl + k            Delete the sentence after the cursor
  Ctrl + u            Delete the sentence before the cursor

  Ctrl + l            Clear the screen
  Ctrl + c            Stop the model from responding
  Ctrl + d            Exit ollama (/bye)
```

