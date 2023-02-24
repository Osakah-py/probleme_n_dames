from PIL import Image

# Charger l'image
img = Image.open("queen.png")

# Convertir l'image en mode RVB (Red Green Blue)
img = img.convert("RGBA")
img = img.resize((img.width // 2, img.height // 2))
# Obtenir la taille de l'image
width, height = img.size

# Créer une matrice pour stocker les couleurs hexadécimales de chaque pixel
pixels = [[0 for _ in range(width)] for _ in range(height)]

# Parcourir chaque pixel de l'image et stocker sa couleur hexadécimale dans la matrice
for y in range(height):
    for x in range(width):
        r, g, b, a = img.getpixel((x, y))
        if a == 0:
            pixels[y][x] = "t"
        else:
            hex_color = f"0x{r:02x}{g:02x}{b:02x}"
            pixels[y][x] = hex_color

# Copie des pixels dans le fichier color.txt au format d'une matrice OCaml
with open("colors.txt", "w") as f:
    f.write("[|")
    for list in pixels :
        f.write("[|")
        for p in list :
            f.write(p)
            f.write(";")
        f.write ("|]; \n")
    f.write("|]")