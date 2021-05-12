function aux.aclimit(e,re,tp)
	if not re:IsHasType(EFFECT_TYPE_ACTIVATE) or not re:IsActiveType(TYPE_PENDULUM)
	   or re:IsActiveType(TYPE_FIELD) then return false end
	return Duel.IsExistingMatchingCard(aux.IsAtMainZone,e:GetHandlerPlayer(),LOCATION_SZONE,0,3,nil)
end
function aux.SZoneLimit(tp)
	--from ダーク・シムルグ
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SSET)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTarget(aux.CannotSetCond)
	e1:SetTargetRange(1,0)
	Duel.RegisterEffect(e1,tp)
	--from 魔封じの芳香
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetCode(EFFECT_CANNOT_ACTIVATE)
	e2:SetTargetRange(1,0)
	e2:SetValue(aux.aclimit)
	Duel.RegisterEffect(e2,tp)
	--max szone
	local e3=Effect.GlobalEffect()
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_MAX_SZONE)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetValue(3)
	Duel.RegisterEffect(e3,tp)
end

function aux.CannotSetCond(e,c)
	return Duel.IsExistingMatchingCard(aux.IsAtMainZone,e:GetHandlerPlayer(),LOCATION_SZONE,0,3,nil) and not c:IsType(TYPE_FIELD)
end

function aux.MZoneLimit(tp)
	local e4=Effect.GlobalEffect()
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetCode(EFFECT_DISABLE_FIELD)
	e4:SetProperty(EFFECT_FLAG_REPEAT)
	e4:SetCondition(aux.SummonCondition)
	e4:SetOperation(aux.DisableMonsterZone)
	Duel.RegisterEffect(e4,tp)
	--max mzone
	local e5=Effect.GlobalEffect()
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_MAX_MZONE)
	e5:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e5:SetTargetRange(1,0)
	e5:SetValue(4)
	Duel.RegisterEffect(e5,tp)
end
function aux.SequenceToZone(seq)
	return 1 << seq
end
function aux.DisableMonsterZone(e,tp)
	local g=Duel.GetMatchingGroup(aux.IsAtMainZone,e:GetHandlerPlayer(),LOCATION_MZONE,0,nil)
	local zone=0x1f
	local c = g:GetFirst()
	while c do
		zone=zone-aux.SequenceToZone(c:GetSequence())
		c = g:GetNext()
	end
	return zone
end

function aux.SummonCondition(e,c,sump,sumtype,sumpos,targetp,se)
	return Duel.IsExistingMatchingCard(aux.IsAtMainZone,e:GetHandlerPlayer(),LOCATION_MZONE,0,3,nil) and (not c or not c:IsLocation(LOCATION_EXTRA))
end

function aux.AdjustRegist()
	--adjust
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e1:SetCode(EVENT_ADJUST)
	e1:SetOperation(aux.AdjustOperation)
	Duel.RegisterEffect(e1,0)
	--adjust
	local e2=Effect.GlobalEffect()
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
	e2:SetCode(EVENT_ADJUST)
	e2:SetOperation(aux.AdjustOperationMonster)
	Duel.RegisterEffect(e2,0)
end

function aux.AdjustOperationMonster(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if (phase==PHASE_DAMAGE and not Duel.IsDamageCalculated()) or phase==PHASE_DAMAGE_CAL then return end
	local g1=Duel.GetMatchingGroup(aux.IsAtMainZone,tp,LOCATION_MZONE,0,nil)
	local g2=Duel.GetMatchingGroup(aux.IsAtMainZone,tp,0,LOCATION_MZONE,nil)
	local c1=g1:GetCount()
	local c2=g2:GetCount()

	if c1>3 or c2>3 then
		local g=Group.CreateGroup()
		if c1>3 then
			local g1 = g1:RandomSelect(tp,c1-3)
			g:Merge(g1)
		end
		if c2>3 then
			local g2 = g2:RandomSelect(tp,c2-3)
			g:Merge(g2)
		end
		local c = g:GetFirst()
		while c do
			Duel.Exile(c,REASON_RULE)
			c = g:GetNext()
		end
		Duel.Readjust()
	end
end

function aux.IsAtMainZone(c)
	return c:GetSequence()<5
end

function aux.AdjustOperation(e,tp,eg,ep,ev,re,r,rp)
	local phase=Duel.GetCurrentPhase()
	if (phase==PHASE_DAMAGE and not Duel.IsDamageCalculated()) or phase==PHASE_DAMAGE_CAL then return end
	local g1=Duel.GetMatchingGroup(aux.IsAtMainZone,tp,LOCATION_SZONE,0,nil)
	local g2=Duel.GetMatchingGroup(aux.IsAtMainZone,tp,0,LOCATION_SZONE,nil)
	local c1=g1:GetCount()
	local c2=g2:GetCount()

	if c1>3 or c2>3 then
		local g=Group.CreateGroup()
		if c1>3 then
			local g1 = g1:RandomSelect(tp,c1-3)
			g:Merge(g1)
		end
		if c2>3 then
			local g2 = g2:RandomSelect(tp,c2-3)
			g:Merge(g2)
		end
		local c = g:GetFirst()
		while c do
			Duel.Exile(c,REASON_RULE)
			c = g:GetNext()
		end
		Duel.Readjust()
	end
end

function aux.SkipM2()
	--skip
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetCode(EFFECT_SKIP_M2)
	Duel.RegisterEffect(e1,0)
end

function aux.DisableBigDamage()
	--avoid damage
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CHANGE_DAMAGE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,1)
	e1:SetValue(aux.DisableBigDamageValue)
	Duel.RegisterEffect(e1,0)
end
function aux.DisableBigDamageValue(e,re,val,r,rp,rc)
	if r&REASON_EFFECT==REASON_EFFECT and val>=3000 then return 3000 end
	return val
end
function aux.CheckDesDeckFilter(c,tp)
	return c:IsPreviousLocation(LOCATION_DECK) and c:IsControler(tp)
end
aux.DeckDesCount={}
function aux.CheckDesDeckCondition(e,tp,eg,ep,ev,re,r,rp)
	return re and bit.band(r,REASON_EFFECT)~=0 and re:GetHandler():GetOwner()~=tp
		and eg:IsExists(aux.CheckDesDeckFilter,1,nil,tp)
end
function aux.CheckDesDeckOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(aux.CheckDesDeckFilter,nil,tp)
	aux.DeckDesCount[tp] = aux.DeckDesCount[tp] + g:GetCount()
	if aux.DeckDesCount[tp] >= 8 then
		Duel.SetLP(1-tp,0)
	end
end
function aux.CheckDesDeck()
	aux.DeckDesCount[0]=0
	aux.DeckDesCount[1]=0
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_TO_GRAVE)
	e1:SetCondition(aux.CheckDesDeckCondition)
	e1:SetOperation(aux.CheckDesDeckOperation)
	Duel.RegisterEffect(e1,0)
	local e=e1:Clone()
	Duel.RegisterEffect(e,1)
	local e2=e1:Clone()
	e2:SetCode(EVENT_REMOVE)
	Duel.RegisterEffect(e2,0)
	e=e2:Clone()
	Duel.RegisterEffect(e,1)
	local e3=e1:Clone()
	e3:SetCode(EVENT_TO_HAND)
	Duel.RegisterEffect(e3,0)
	e=e3:Clone()
	Duel.RegisterEffect(e,1)
end
function aux.CannotActivate(tp)
	if not aux.SP4 then
		aux.SP4={73915051,78785392}
		aux.SP3={18027138,40975243,18322364,33298291,34707034,49808196,50750868,56051648,65664792,7949763,72537897,73199638,93224848,96383838,97433739}
		aux.SP3Ex={7392745,29843091,42956963}
		aux.SP2={1969506,6148016,7161742,9925982,9929398,10698416,10971759,10971759,13482262,13504844,14604710,15341821,15394083,17418744,17502671,20285786,21007444,21179143,22110647,23536866,29087919,31986288,33551032,39998992,40450317,40844552,41197012,41442341,43140791,44161893,46005939,46173679,48411996,51205763,51987571,55416843,56337500,56597272,57288708,58531587,58787301,60764581,60930169,61314842,61840587,61948106,62376646,64496451,66393507,71541986,71867500,73906480,74875003,80701178,76930964,77642288,77847678,80802524,81587028,82324105,86174055,92781606}
		aux.SP2Ex={14470845,28062325,41141943,75252099,93749093,93775296}
	end
	--cannot activate
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetValue(aux.CannotActivateValue)
	Duel.RegisterEffect(e1,tp)
end
function aux.IsTableContainValue(tbl,val)
	for k,v in ipairs(tbl) do
		if v==val then return true end
	end
	return false
end
function aux.CannotActivateValue(e,te,tp)
	if tp~=e:GetHandlerPlayer() then return false end
	local mon=Duel.GetMatchingGroupCount(aux.IsAtMainZone,tp,LOCATION_MZONE,0,nil)
	local enemymon=Duel.GetMatchingGroupCount(aux.IsAtMainZone,tp,0,LOCATION_MZONE,nil)
	local c=te:GetHandler()
	if not c then return false end
	local code=c:GetCode()
	if aux.IsTableContainValue(aux.SP4,code) then return true end
	if mon>0 and aux.IsTableContainValue(aux.SP3,code) then return true end
	if enemymon>0 and aux.IsTableContainValue(aux.SP3Ex,code) then return true end
	if mon>0 and code==53315891 and te:GetHandler():IsLocation(LOCATION_GRAVE) then return true end
	if mon>0 and code==44097050 and te:GetType()~=EFFECT_TYPE_IGNITION then return true end
	if mon>1 and aux.IsTableContainValue(aux.SP2,code) then return true end
	if enemymon>1 and aux.IsTableContainValue(aux.SP2Ex,code) then return true end
	if mon>1 and code==22227683 and te:GetCode()==EVENT_BATTLE_DESTROYING then return true end
	if mon>1 and code==58054262 and te:GetCategory()==CATEGORY_SPECIAL_SUMMON then return true end
	if mon>1 and code==25669282 and te:GetHandler():IsLocation(LOCATION_GRAVE) then return true end
	if mon>1 and code==27198001 and te:GetCode()==EVENT_TO_GRAVE then return true end
	if mon>1 and code==34767865 and te:GetRange()==LOCATION_GRAVE then return true end
	if mon>1 and code==41933425 and te:GetCode()==EVENT_FREE_CHAIN then return true end
	if mon>1 and code==43138260 and te:GetCode()==EVENT_SPSUMMON_SUCCESS then return true end
	if mon>1 and code==48736598 and te:GetCode()==EVENT_SPSUMMON_SUCCESS then return true end
	if mon>1 and code==53855409 and te:GetCode()==EVENT_BE_MATERIAL then return true end
	if mon>1 and code==62481203 and te:GetCode()==EVENT_FREE_CHAIN then return true end
	if mon>1 and code==66141736 and te:GetRange()==LOCATION_GRAVE then return true end
	if mon>1 and code==66200210 and te:GetCode()==EVENT_FLIP then return true end
	if mon>1 and code==76647978 and te:GetRange()==LOCATION_GRAVE then return true end
	if mon>1 and (code==83293307 or code==86174055) and te:GetCode()==EVENT_LEAVE_FIELD then return true end
	if mon>1 and code==92559258 and te:GetCategory()==CATEGORY_SPECIAL_SUMMON then return true end
	if mon>1 and code==96381979 and te:GetCode()==EVENT_TO_GRAVE then return true end
	return false
end
function aux.PreloadUds()
	aux.SZoneLimit(0)
	aux.SZoneLimit(1)
	aux.MZoneLimit(0)
	aux.MZoneLimit(1)
	aux.CannotActivate(0)
	aux.CannotActivate(1)
	aux.AdjustRegist()
	aux.SkipM2()
	aux.DisableBigDamage()
	aux.CheckDesDeck()
end