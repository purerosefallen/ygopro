--高速决斗技能-XYZ猎人
Duel.LoadScript("speed_duel_common.lua")
function c100730124.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730124.skill,c100730124.con,aux.Stringid(100730124,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730124.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c100730124.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730124.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(Card.IsType,1-tp,LOCATION_MZONE,0,1,nil,TYPE_XYZ)
end
function c100730124.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730124)
	local g=Duel.GetMatchingGroup(c100730124.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local ct=Duel.GetOverlayCount(1-tp,LOCATION_MZONE,0)*700
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(ct)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end