# linkedin-connector

Original Project : https://github.com/LearnerChao/LinkDriver

LinkDriver is a tool for connecting people with their interested Linkedin users automatically and massively.

## Getting Started Guide

1) install ruby, watir

http://watir.com/installation/

```bash
brew install ruby
gem install watir
```

2) Change properties.config.yml.template to properties.config.yml
Put your configuration into properties.config.yml file; Make sure you are using white spaces instead of tab for the indent
3) Change the file path in .config_file_path to the path of properties.config.yml file:
```bash
path: '/root/path/to/properties.config.yml'
```
4) Download Chrome Driver Executable from here:
```bash
http://chromedriver.storage.googleapis.com/index.html
```
put it in the PATH directory. Or, I have add chromedriver in the project. You could supplement the project path to PATH"


### Start running

* To run this program, you need to go to your terminal, change the directory to the root folder of this project, then run
```bash
ruby step_entry_point.rb
```

## License

The MIT License (MIT)
Copyright (c) 2016 Learner Chao

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
