from flask import Flask, request, jsonify
import config  # Assurez-vous que config est importé correctement
from app import main

resultat = main.MainFunction()  # Assurez-vous que MainFunction prend les bons paramètres si nécessaire
print(resultat)