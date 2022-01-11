import 'package:flutter/cupertino.dart';
import 'package:pokedex_app/model/pokemon.dart';

class PokemonDetailCard extends StatelessWidget {
  final PokemonDetail pokemonDetail;

  const PokemonDetailCard({Key? key, required this.pokemonDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Center(
              child: Hero(
                  tag: pokemonDetail.name,
                  child: Image.network(
                    pokemonDetail.sprite.oficcialArtWork,
                  )
                  //scale: 0.5,
                  )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Name",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 18)),
              const SizedBox(
                width: 20,
              ),
              Text(
                pokemonDetail.name.toUpperCase(),
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(children: const [
            Text("Types",
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 18))
          ]),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: buildTypesImagesFromResources(pokemonDetail.types),
          )
        ],
      ));

  List<Widget> buildTypesImagesFromResources(List<PokemonType> pokemonTypes) {
    return pokemonTypes.map((pt) {
      String calculatedResourcePath = "images/${pt.name}.png";

      return Center(child: ImageContainer(imagePath: calculatedResourcePath));
    }).toList();
  }
}

class ImageContainer extends StatelessWidget {
  const ImageContainer({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image(
        image: AssetImage(imagePath),
      ),
    );
  }
}
