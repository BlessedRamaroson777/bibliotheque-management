<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Inscription Membre</title>
    <link rel="stylesheet" href="css/style.css"/>
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
        
        .registration-container {
            background-color: white;
            padding: 2rem 3rem;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 600px;
        }
        
        h2 {
            color: #3498db;
            text-align: center;
            margin-bottom: 1.5rem;
            font-weight: 600;
        }
        
        .form-group {
            margin-bottom: 1.2rem;
        }
        
        label {
            display: block;
            font-weight: 500;
            margin-bottom: 0.5rem;
            color: #2c3e50;
        }
        
        input[type="text"],
        input[type="email"],
        input[type="password"],
        input[type="datetime-local"],
        select {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            box-sizing: border-box;
        }
        
        select {
            appearance: none;
            background-image: url("data:image/svg+xml;charset=UTF-8,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3e%3cpolyline points='6 9 12 15 18 9'%3e%3c/polyline%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 0.8rem center;
            background-size: 1rem;
        }
        
        input:focus,
        select:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }
        
        .submit-btn {
            background-color: #3498db;
            color: white;
            padding: 0.8rem;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s;
            width: 100%;
            margin-top: 1rem;
            font-weight: 500;
        }
        
        .submit-btn:hover {
            background-color: #2980b9;
            transform: translateY(-2px);
        }
        
        .error-message {
            color: #e74c3c;
            padding: 0.8rem;
            margin-bottom: 1rem;
            background-color: rgba(231, 76, 60, 0.1);
            border-radius: 4px;
            text-align: center;
        }
        
        .success-message {
            color: #27ae60;
            padding: 0.8rem;
            margin-bottom: 1rem;
            background-color: rgba(39, 174, 96, 0.1);
            border-radius: 4px;
            text-align: center;
        }
        
        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1rem;
        }
        
        @media (max-width: 600px) {
            .form-row {
                grid-template-columns: 1fr;
            }
            
            .registration-container {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="registration-container">
        <h2>Inscription d'un nouveau membre</h2>
        
        <c:if test="${not empty error}">
            <div class="error-message">${error}</div>
        </c:if>
        <c:if test="${not empty message}">
            <div class="success-message">${message}</div>
        </c:if>
        
        <form action="inscrire" method="post">
            <div class="form-group">
                <label for="nomUtilisateur">Nom:</label>
                <input type="text" name="nomUtilisateur" id="nomUtilisateur" required/>
            </div>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" name="email" id="email" required/>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="motDePasse">Mot de passe:</label>
                    <input type="password" name="motDePasse" id="motDePasse" required/>
                </div>
                <div class="form-group">
                    <label for="confirmationMotDePasse">Confirmer:</label>
                    <input type="password" name="confirmationMotDePasse" id="confirmationMotDePasse" required/>
                </div>
            </div>
            
            <div class="form-row">
                <div class="form-group">
                    <label for="dateInscription">Date inscription:</label>
                    <input type="datetime-local" name="dateInscription" id="dateInscription" required/>
                </div>
                <div class="form-group">
                    <label for="dateNaissance">Date de naissance:</label>
                    <input type="datetime-local" name="dateNaissance" id="dateNaissance" required/>
                </div>
            </div>
            
            <div class="form-group">
                <label for="idTypeMembre">Type membre:</label>
                <select name="idTypeMembre" id="idTypeMembre" required>
                    <%
                        java.util.List<com.bibliotheque.model.TypeMembre> TypeMembres = (java.util.List<com.bibliotheque.model.TypeMembre>) request.getAttribute("typesMembres");
                        for (com.bibliotheque.model.TypeMembre c : TypeMembres) {
                    %>
                        <option value="<%= c.getId() %>"><%= c.getNom() %></option>
                    <% } %>
                </select>
            </div>
            
            <input type="submit" value="Inscrire" class="submit-btn"/>
        </form>
    </div>
</body>
</html>