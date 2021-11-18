import os
path = os.getcwd()
path = path + "/" + "frontend"
srcPath = path + "/" + "src"
componentsPath = srcPath + "/" + "components"
chartPath = componentsPath + "/" + "Chart"
userPath = componentsPath + "/" + "User"
workingTimesPath= componentsPath + "/" + "WorkingTime"
viewPath = srcPath + "/" + "views"

os.chdir(srcPath)
os.chdir(componentsPath)
print(os.getcwd())

hostName = "http://localhost:4000"
rightHostname = "https://timeback.saucisse.pw:443"

file = open("Button_Dashboard.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("Button_Dashboard.vue", 'w') as file:
        file.write(fileData)
file.close()
        
file = open("ClockManager.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("ClockManager.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("TeamsManager.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("TeamsManager.vue", 'w') as file:
        file.write(fileData)
file.close()

file = open("WorkingTimes.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("WorkingTimes.vue", 'w') as file:
        file.write(fileData)
file.close()

os.chdir(chartPath)
file = open("ChartUserManager.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("ChartUserManager.vue", 'w') as file:
        file.write(fileData)
file.close()
os.chdir(componentsPath)

os.chdir(userPath)
file = open("CreateUser.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("CreateUser.vue", 'w') as file:
        file.write(fileData)
file.close()
os.chdir(componentsPath)

os.chdir(userPath)
file = open("DeleteUser.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("DeleteUser.vue", 'w') as file:
        file.write(fileData)
file.close()
os.chdir(componentsPath)

os.chdir(userPath)
file = open("GetUser.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("GetUser.vue", 'w') as file:
        file.write(fileData)
file.close()
os.chdir(componentsPath)

os.chdir(userPath)
file = open("ManageUser.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("ManageUser.vue", 'w') as file:
        file.write(fileData)
os.chdir(componentsPath)
file.close()

os.chdir(userPath)
file = open("UpdateUser.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("UpdateUser.vue", 'w') as file:
        file.write(fileData)
file.close()
os.chdir(componentsPath)

os.chdir(workingTimesPath)
file = open("CreateWorkingTime.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("CreateWorkingTime.vue", 'w') as file:
        file.write(fileData)
file.close()
os.chdir(componentsPath)

os.chdir(workingTimesPath)
file = open("DeleteWorkingTime.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("DeleteWorkingTime.vue", 'w') as file:
        file.write(fileData)
file.close()
os.chdir(componentsPath)

os.chdir(workingTimesPath)
file = open("ShowUserWorkingTime.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("ShowUserWorkingTime.vue", 'w') as file:
        file.write(fileData)
file.close()
os.chdir(componentsPath)

os.chdir(workingTimesPath)
file = open("ShowWorkingTime.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("ShowWorkingTime.vue", 'w') as file:
        file.write(fileData)
file.close()
os.chdir(componentsPath)

os.chdir(workingTimesPath)
file = open("UpdateWorkingTime.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("UpdateWorkingTime.vue", 'w') as file:
        file.write(fileData)
file.close()
os.chdir(componentsPath)

os.chdir(viewPath)
file = open("LogIn.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("LogIn.vue", 'w') as file:
        file.write(fileData)
file.close()
os.chdir(componentsPath)

os.chdir(viewPath)
file = open("SignIn.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("SignIn.vue", 'w') as file:
        file.write(fileData)
file.close()
os.chdir(componentsPath)

os.chdir(viewPath)
file = open("UserView.vue", "r")
fileData = file.read()
fileData = fileData.replace(hostName, rightHostname)
with open("UserView.vue", 'w') as file:
        file.write(fileData)
file.close()
os.chdir(componentsPath)
