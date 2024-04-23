function do_sth_with_PlayerParty(playerId, membername)
    -- I am assuming here this function is part of the player somehow so "player" is already declared
    player = Player(playerId)
    local party = player:getParty()

    for k, v in pairs(party:getMembers()) do
        --[[ It doesn't make sense to compare the pointer of the member in my party to a newly created Player by using just a membername
         Especially when at line 2 we create a Player out of just the Id, how do we even split up in the same constructor
         two different ways of creating the same thing but one is with ID and another with a simple name?
         That's why I decided to remove Player(membername) and just compare with the name of the player currently
          in my party has the name I am looking for ]] --
        if v.name == membername then
            party:removeMember(Player(membername))
        end
    end
end
