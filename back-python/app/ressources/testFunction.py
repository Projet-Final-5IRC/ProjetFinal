print(f"likes_str : {likes_str}")
    likes_list = list(map(int, likes_str.split(',')))  # Conversion en liste d'entiers
    print(f"likes_list : {likes_list}")
    
    if likes_list:  # Vérification si la liste n'est pas vide
        for i in range(len(likes_list)):
            numberLike = likes_list[i]
            print(f"numberLike : {numberLike}")
            new_entry_data = {}
            
            # Ouvrir les données du film correspondant
            result = mef_like_user(entry_data, str(numberLike))
            print(f"Résultat pour le film {numberLike}: {result}")
            
            if result:
                film_data = result[0]  # Prendre le premier dictionnaire de la liste
                print(f"Données du film récupérées : {film_data}")
                
                # Récupérer les données pertinentes de l'image
                for topic in topic_list:
                    if topic in film_data:
                        new_entry_data[topic] = film_data.get(topic)
                        print(f"{topic} ajouté depuis film_data")
                    elif topic in entry_data:
                        new_entry_data[topic] = entry_data.get(topic)
                        print(f"{topic} ajouté depuis entry_data")
                
                # Ajouter les données formatées à la liste des données
                exitData.append(new_entry_data)
                print(f"new_entry_data à la fin de la boucle: {new_entry_data}")
                print("-----------------------------------")
            else:
                print(f"Le film {numberLike} n'existe plus.")
    