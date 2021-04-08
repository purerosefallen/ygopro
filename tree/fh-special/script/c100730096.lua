--高速决斗技能-元素合体！
Duel.LoadScript("speed_duel_common.lua")
function c100730096.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730096.skill,c100730096.con,aux.Stringid(100730096,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730096.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	local g=Duel.GetFieldGroup(tp,LOCATION_ONFIELD,0)
	local sg=g:Filter(Card.IsFaceup,nil)
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK,0,1,nil,25955164,98434877,62340868)
		and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,nil,25833572)
		and Duel.IsExistingMatchingCard(Card.IsAbleToDeck,tp,LOCATION_HAND,0,2,nil)
		and sg:GetCount()<=0
end
function c100730096.skill(e,tp,c)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730096)
	local g=Duel.GetMatchingGroup(Card.IsAbleToDeck,tp,LOCATION_HAND,0,3,nil)
	local c=g:Select(tp,2,2,nil)
	if c then
		Duel.SendtoDeck(c,nil,2,REASON_RULE)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c100730096.filter),tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil)
		if g:GetCount()==0 then return end
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		local tc=g:GetFirst()
		if not tc then return end
		Duel.SpecialSummonStep(tc,0,tp,tp,true,true,POS_FACEUP)
		local e2=Effect.GlobalEffect()   
		e2:SetType(EFFECT_TYPE_FIELD)
		e2:SetCode(EFFECT_CHANGE_DAMAGE)
		e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
		e2:SetTargetRange(0,1)
		e2:SetValue(c100730096.damval)
		e2:SetReset(RESET_PHASE+PHASE_END)
		Duel.RegisterEffect(e2,tp) 
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local c=e:GetHandler()
		local g1=Duel.SelectMatchingCard(tp,c100730096.filter2,tp,LOCATION_DECK,0,1,3,nil)
		local ft=Duel.GetLocationCount(tp,LOCATION_SZONE)
		if ft<g1:GetCount() then return end
		Duel.SetOperationInfo(0,CATEGORY_EQUIP,g1,count,0,0)
		local qc=g1:GetFirst()
		qc:RegisterFlagEffect(100730096,RESET_EVENT+RESETS_STANDARD,0,0)
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(c100730096.eqlimit)
		Duel.RegisterEffect(e1,qc)
		while qc do
		   Duel.Equip(tp,qc,tc,true,true)
		   qc=g1:GetNext()
		end
		local count=tc:GetEquipCount()
		local e3=Effect.CreateEffect(tc)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetRange(LOCATION_MZONE)
		e3:SetCode(EFFECT_EXTRA_ATTACK_MONSTER)
		e3:SetValue(count-1)
		tc:RegisterEffect(e3)
		local e4=Effect.CreateEffect(tc)
		e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_DESTROY_REPLACE)
		e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e4:SetRange(LOCATION_MZONE)
		e4:SetTarget(c100730096.desreptg)
		e4:SetOperation(c100730096.desrepop)
		tc:RegisterEffect(e4)
	end
	Duel.SpecialSummonComplete()
end
function c100730096.repfilter(c,e)
	return c:IsFaceup()
		and c:IsCode(25955164) or c:IsCode(62340868) or c:IsCode(98434877)
		and c:IsDestructable(e) and not c:IsStatus(STATUS_DESTROY_CONFIRMED+STATUS_BATTLE_DESTROYED)
end
function c100730096.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return not c:IsReason(REASON_REPLACE) and c:IsOnField() and c:IsFaceup()
		and Duel.IsExistingMatchingCard(c100730096.repfilter,tp,LOCATION_SZONE,0,1,c,e) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c100730096.repfilter,tp,LOCATION_SZONE,0,1,1,c,e)
		e:SetLabelObject(g:GetFirst())
		g:GetFirst():SetStatus(STATUS_DESTROY_CONFIRMED,true)
		return true
	else return false end
end
function c100730096.desrepop(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetLabelObject()
	tc:SetStatus(STATUS_DESTROY_CONFIRMED,false)
	Duel.Destroy(tc,REASON_EFFECT+REASON_REPLACE)
end
function c100730096.damval(e,re,val,r,rp,rc)
	return math.floor(val/2)
end
function c100730096.eqlimit(e,c)
	return e:GetOwner()==c
end
function c100730096.filter(c)
	return c:IsCode(25833572)
end

function c100730096.filter2(c)
	return c:IsCode(25955164) or c:IsCode(62340868) or c:IsCode(98434877)
end