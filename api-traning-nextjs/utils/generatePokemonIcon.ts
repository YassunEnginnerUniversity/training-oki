export const generatePokemonIcon = (username:string) => {
  const baseSrc = "pokemon0"
  const pokemonImageNumber = username.replace("user_", "")

  if(Number(pokemonImageNumber) > 15) {
    return "no-image.png"
  }

  const pokemonImageSrc = baseSrc + pokemonImageNumber
  return pokemonImageSrc
}