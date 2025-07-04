<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Cotiser</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css"/>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            color: #333;
        }
        
        .cotisation-container {
            background-color: white;
            padding: 2rem 3rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 500px;
        }
        
        h2 {
            color: #3498db; /* Bleu cohérent avec la page utilisateur */
            text-align: center;
            margin-bottom: 1.5rem;
            font-weight: 600;
        }
        
        .form-row {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.2rem;
        }
        
        .form-group {
            flex: 1;
        }
        
        label {
            display: block;
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #2c3e50;
        }
        
        input[type="datetime-local"] {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            box-sizing: border-box;
        }
        
        input[type="datetime-local"]:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }
        
        input[type="submit"] {
            background-color: #3498db;
            color: white;
            padding: 0.8rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100%;
            margin-top: 0.5rem;
        }
        
        input[type="submit"]:hover {
            background-color: #2980b9;
        }
        
        .message {
            color: #27ae60;
            text-align: center;
            margin-top: 1rem;
            padding: 0.5rem;
            background-color: rgba(39, 174, 96, 0.1);
            border-radius: 4px;
        }
        
        @media (max-width: 600px) {
            .form-row {
                flex-direction: column;
                gap: 0;
            }
            
            .cotisation-container {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="cotisation-container">
        <h2>Nouvelle cotisation</h2>
        <form action="cotiser" method="post">
            <div class="form-row">
                <div class="form-group">
                    <label for="dateDebut">Date début :</label>
                    <input type="datetime-local" name="dateDebut" id="dateDebut" required/>
                </div>
                <div class="form-group">
                    <label for="dateFin">Date fin :</label>
                    <input type="datetime-local" name="dateFin" id="dateFin" required/>
                </div>
            </div>
            <input type="submit" value="Cotiser"/>
        </form>
        <div class="message">${message}</div>
    </div>
</body>
</html>