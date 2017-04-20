local shell = require("shell")
 
while true do
    shell.execute("gather 3 3")
	for i=1, 60 do
    os.sleep(60)
    print(60-i,".. minutes to GO")
  end
end