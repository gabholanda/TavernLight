local function releaseStorage(player, storageId)
    player:setStorageValue(storageId, -1)
end

--[[
    I am assuming the 1000 means the storageId since it doesn't make sense to be a delayInMs.
    So as an improvement I decided to turn it into a local variable.
    Of course another option would be for to take our magic number here and make it come as parameter for the onLogout function.
    Also in my mind it doesn't make sense to have a "get" function to something so specific having a parameter passed ot it.
    Usually when we make a "get" it takes no arguments and just return whatever value stored inside unless we trying to retrieve
    some kind of data from a list such as getInventoryItem(itemID)
]]--
function onLogout(player)
    local storageId = 1000;
    if player:getStorageValue() == 1 then
        addEvent(releaseStorage, storageId, player)
    end
    return true
end


onLogout(nil);