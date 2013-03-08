TileMap tilemap_null_tileMap();

void tilemap_render(TileMap tileMap, Point pos);
Point tilemap_tilePositionFromIndex(const TileMap* tileMap, int i);
int tilemap_indexFromTilePosition(const TileMap* tileMap, Point p);
bool tilemap_collides(const TileMap* tileMap, Point p);
