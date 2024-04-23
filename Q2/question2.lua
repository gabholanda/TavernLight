function printSmallGuildNames(memberCount)
    -- Substituted string concatenation to parametrization to avoid SQL Injection (%d to ?)
    local selectGuildQuery = "SELECT name FROM guilds WHERE max_members < ?;"
    -- Of course I am assuming whatever framework/lib it's being used has these functions
    local result = db.storeQuery(string.format(selectGuildQuery, memberCount))

    -- Error handling in case we don't find anything
    if not result then
        print("Failed to execute SQL query")
        return
    end

    -- Fetch and print guild names, previous function would assumingly only print the first one.
    repeat
        local row = result.fetchNext()
        if row then
            local guildName = result.getDataString(row, "name")
            print(guildName)
        end
    until not row

     -- Free the result set, good practice to free db usage
     result.free()
end
