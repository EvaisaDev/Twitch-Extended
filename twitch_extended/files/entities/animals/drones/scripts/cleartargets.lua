dofile( "data/scripts/lib/utilities.lua" )


local ourEntity = GetUpdatedEntityID()

local ourAnimalComponent = EntityGetComponent(ourEntity, "AnimalAIComponent")[1]


ComponentSetValue( ourAnimalComponent, "mGreatestThreat", 0 )
ComponentSetValue( ourAnimalComponent, "mGreatestPrey", 0 )
ComponentSetValue( ourAnimalComponent, "mHasBeenAttackedByPlayer", 0 )
