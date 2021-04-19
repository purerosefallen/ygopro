--高速决斗技能-来自深海的恐怖
Duel.LoadScript("speed_duel_common.lua")
function c100730181.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730181.skill,c100730181.con,aux.Stringid(100730181,0))
	aux.RegisterSpeedDuelSkillCardCommon()
	aux.SpeedDuelBeforeDraw(c,c100730181.skill2)
end
function c100730181.Iskai(c)
	return c:IsCode(76634149) and c:IsFaceup()
end
function c100730181.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730181.Iskai,tp,LOCATION_MZONE,0,1,nil)and Duel.IsExistingMatchingCard(c100730181.filter,tp,LOCATION_FZONE+LOCATION_GRAVE+LOCATION_DECK+LOCATION_HAND,0,1,nil)
end
function c100730181.kaicon(e,tp)
	return Duel.IsExistingMatchingCard(c100730181.Iskai,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil)
end
function c100730181.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730181)
	local g1=Duel.GetMatchingGroup(c100730181.filter,tp,LOCATION_FZONE,0,nil)
	if g1:GetCount()~=0 and Duel.IsPlayerCanDraw(tp,2) then
		Duel.Draw(tp,2,REASON_RULE)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
		local sg=Duel.SelectMatchingCard(tp,Card.IsAbleToDeck,tp,LOCATION_HAND,0,1,1,nil)
		Duel.SendtoDeck(sg,nil,1,REASON_EFFECT)
	end
	if g1:GetCount()==0 then
		local tc=Duel.SelectMatchingCard(tp,c100730181.filter,tp,LOCATION_DECK+LOCATION_GRAVE+LOCATION_HAND,0,1,1,nil,tp):GetFirst()
		Duel.MoveToField(tc,tp,tp,LOCATION_FZONE,POS_FACEUP,true)
		local te=tc:GetActivateEffect()
		Duel.RaiseEvent(tc,4179255,te,0,tp,tp,Duel.GetCurrentChain())
	end
end
function c100730181.filter(c)
	return c:IsCode(22702055)
end
function c100730181.skill2(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	local c=e:GetHandler()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_GRANT)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_IMMUNE_EFFECT)
	e1:SetValue(c100730181.efilter)
	e1:SetCondition(c100730181.kaicon)
	Duel.RegisterEffect(e1,tp)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_LEVEL)
	e2:SetTargetRange(LOCATION_HAND+LOCATION_DECK+LOCATION_MZONE,0)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsAttribute,ATTRIBUTE_WATER))
	e2:SetValue(-1)
	Duel.RegisterEffect(e2,tp)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_SET_BASE_ATTACK)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c100730181.waterfilter)
	e3:SetValue(c100730181.val)
	Duel.RegisterEffect(e3,tp)
	e:Reset()
end
function c100730181.efilter(e,te)
	local c=te:GetHandler()
	return c:GetType()==TYPE_TRAP 
end
function c100730181.val(e,c)
	return c:GetOriginalLevel()*500
end
function c100730181.waterfilter(e,c)
	return c:IsAttribute(ATTRIBUTE_WATER) and c:IsLevelBelow(4)
end