from app.ressources import CallApi as cap

def MainFouineGenre(): 
    
    result = cap.CallMovieFouineGender()

    return result


def mainFouine():
    
    result = cap.CallMovieFouine()
    
    return result