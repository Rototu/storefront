cd "frontend\StoreHTML"
dotnet publish
cd "../../"
robocopy frontend\\StoreHTML\\src\\StoreHTML.Client\\bin\\Debug\\netstandard2.1\\publish\\wwwroot static * /mir
go build -o bin\StoreServer_win.exe