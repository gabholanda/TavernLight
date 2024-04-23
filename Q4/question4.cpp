#include <string>

class Something
{
};

class Player
{
public:
    Player();
    Player(Something *something);
};

class Game
{
public:
    void addItemToPlayer(const std::string &recipient, uint16_t itemId);
};

class Item
{
public:
    static Item *CreateItem(uint16_t itemId);
};

void Game::addItemToPlayer(const std::string &recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);
    if (!player)
    {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient))
        {
            // Deallocating player here as it is no longer needed as the player wasn't found.
            delete player; 
            return;
        }
    }

    Item *item = Item::CreateItem(itemId);
    
    if (!item)
    {
        // no need to delete an item here as it can be inferred that CreateItem returns a nullptr in case it fails.
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline())
    {
        IOLoginData::savePlayer(player);
    }

    // We also deallocate player here as it is no longer needed, but we keep item as it was internally added in the g_game
    // Overall I would have used smart pointers here, but it seems I am supposed to use only raw pointers.
    delete player; 
}