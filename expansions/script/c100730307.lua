--高速决斗技能-骰子爆发
Duel.LoadScript("speed_duel_common.lua")
function c100730307.initial_effect(c)
	aux.SpeedDuelMoveCardToFieldCommon(39454112,c)
	aux.SpeedDuelAtMainPhase(c,c100730307.skill,c100730307.con,aux.Stringid(100730307,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730307.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c100730307.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730307.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c100730307.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730307)
	local g=Duel.GetMatchingGroup(c100730307.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local ct=Duel.TossDice(tp,1)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(ct*50)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,1,nil,74137509)
	Duel.SendtoHand(g1,tp,REASON_RULE)
	if ct=1 or ct=6 then return end
	e:Reset()
end