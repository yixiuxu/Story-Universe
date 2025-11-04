@echo off
echo ========================================
echo   安装后端依赖（使用清华镜像）
echo ========================================
echo.

cd backend

echo 正在安装依赖，请稍候...
python -m pip install -i https://pypi.tuna.tsinghua.edu.cn/simple fastapi uvicorn sqlalchemy pydantic python-multipart python-jose passlib zhipuai python-dotenv httpx aiofiles pillow requests pydantic-settings

echo.
echo ========================================
echo   安装完成！
echo ========================================
echo.
echo 现在可以运行后端服务：
echo python -m uvicorn main:app --reload --host 0.0.0.0 --port 8000
echo.

pause
