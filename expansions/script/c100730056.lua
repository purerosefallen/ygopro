--高速决斗技能-强攻压制
Duel.LoadScript("speed_duel_common.lua")
function c100730056.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730056.skill,c100730056.con,aux.Stringid(100730056,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730056.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsLevelAbove(5)
end
function c100730056.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730056.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c100730056.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730056)
	local g=Duel.GetMatchingGroup(c100730056.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local ct=g:GetCount()*300
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