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
	--[[
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetTargetRange(1,0)
	e1:SetCondition(aux.SummonCondition)
	Duel.RegisterEffect(e1,tp)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_MSET)
	Duel.RegisterEffect(e2,tp)
	local e3=e1:Clone()
	e3:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e3:SetCondition(aux.TRUE)
	e3:SetTarget(aux.SummonCondition)
	Duel.RegisterEffect(e3,tp)]]--
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

function aux.EffectNegate(tp)
	--negate
	local e1=Effect.GlobalEffect()
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_CHAIN_SOLVING)
	e1:SetOperation(aux.EffectNegateOperation)
	Duel.RegisterEffect(e1,tp)
end

function aux.NeedEx(c)
	return c:IsLocation(LOCATION_EXTRA) and (c:IsType(TYPE_PENDULUM) or c:IsType(TYPE_LINK))
end

function aux.CanToEx(c)
	return c:IsLocation(LOCATION_EXTRA) and not (c:IsType(TYPE_PENDULUM) or c:IsType(TYPE_LINK))
end

function aux.NoneEffect(e)
	if OriginalEffects[e] then e:SetOperation(OriginalEffects[e]) end
end

OriginalEffects = {}

function aux.EffectNegateOperation(e,tp,eg,ep,ev,re,r,rp)
	if not re:IsHasCategory(CATEGORY_SPECIAL_SUMMON) then return end
	if re:GetHandlerPlayer()~=tp then return end
	local a,g,count,dp,dv = Duel.GetOperationInfo(ev,CATEGORY_SPECIAL_SUMMON)
	local code=re:GetHandler():GetOriginalCode()
	if code==43434803 or code==58551308 or code==22404675 or code==99330325 then return end
	local mainAvailable = 3-Duel.GetMatchingGroupCount(aux.IsAtMainZone,tp,LOCATION_MZONE,0,nil)
	local extraAvailable = Duel.GetMatchingGroupCount(aux.IsExtraMonster,tp,LOCATION_MZONE,0,nil)==0
	local needMain = 0
	if g and aux.GetValueType(g)=="Card" then g=Group.FromCards(g) end
	if g then
		local g2 = g:Clone():Filter(aux.NeedEx,nil)
		local g3 = g:Clone():Filter(aux.CanToEx,nil)
		local needEx = g2:GetCount()
		local canToEx = g3:GetCount()
		needMain = g:GetCount() - g2:GetCount()
		local mainMin = needMain
		local mainMax = needMain + canToEx
		local extraMin = needEx
		local extraMax = needEx + canToEx
		local exZoneCount = Duel.GetLocationCountFromEx(tp)
		if exZoneCount >= extraMin and mainAvailable >= mainMin then return end
	else
		if count then
			needMain = count
			if dv == LOCATION_EXTRA and extraAvailable then needMain = needMain - 1 end
		else
			needMain = 0
		end
	end
	if mainAvailable < needMain then
		if not OriginalEffects[re] then
			OriginalEffects[re] = re:GetOperation()
		end
		re:SetOperation(aux.NoneEffect)
		Duel.Exile(re:GetHandler(),REASON_RULE)
	end
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

function aux.IsExtraMonster(c)
	return c:GetSequence()>=5
end

function aux.Kill(c)
	if c:IsType(TYPE_TOKEN) then
		Duel.Exile(c,REASON_RULE)
	else
		Duel.SendtoGrave(c)
	end
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
	if r&REASON_EFFECT==REASON_EFFECT and val>=2000 then return 0 end
	return val
end
function aux.CheckDesDeckFilter(c,tp)
	return c:IsPreviousLocation(LOCATION_DECK) and c:IsControler(tp)
end
aux.DeckDesCount={}
function aux.CheckDesDeckCondition(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_EFFECT)~=0 and re:GetHandler():GetOwner()~=tp
		and eg:IsExists(aux.CheckDesDeckFilter,1,nil,tp)
end
function aux.CheckDesDeckOperation(e,tp,eg,ep,ev,re,r,rp)
	local g=eg:Filter(aux.CheckDesDeckFilter,nil,tp)
	aux.DeckDesCount[tp] = aux.DeckDesCount[tp] + g:GetCount()
	if aux.DeckDesCount[tp] >= 6 then
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
function aux.PreloadUds()
	aux.SZoneLimit(0)
	aux.SZoneLimit(1)
	aux.MZoneLimit(0)
	aux.MZoneLimit(1)
	aux.EffectNegate(0)
	aux.EffectNegate(1)
	aux.AdjustRegist()
	aux.SkipM2()
	aux.DisableBigDamage()
	aux.CheckDesDeck()
end