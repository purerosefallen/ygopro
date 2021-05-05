--高速决斗技能-科技爆发
Duel.LoadScript("speed_duel_common.lua")
function c100730281.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730281.skill,c100730281.con,aux.Stringid(100730281,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730281.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730281.filter,tp,LOCATION_MZONE,0,1,nil) 
end
function c100730281.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730281)
	local c=e:GetHandler()
	local g1=Duel.GetMatchingGroup(c100730281.IsTG,tp,LOCATION_MZONE,0,nil)
	local g=Duel.GetMatchingGroup(c100730281.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(300*g1:GetCount())
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(tc)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetTargetRange(LOCATION_MZONE,0)
		e2:SetCode(EFFECT_CHANGE_RACE)
		e2:SetReset(RESET_PHASE+PHASE_END)
		e2:SetValue(RACE_MACHINE)
		tc:RegisterEffect(e2)
		tc=g:GetNext()
	end
end
function c100730281.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsSetCard(0x27)
end
function c100730281.IsTG(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsFaceup() and c:IsSetCard(0x27)
end