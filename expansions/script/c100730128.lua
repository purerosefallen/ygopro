--高速决斗技能-超级强壮！
Duel.LoadScript("speed_duel_common.lua")
function c100730128.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730128.skill,c100730128.con,aux.Stringid(100730128,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730128.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730128.filter,tp,LOCATION_MZONE,0,1,nil) 
		and Duel.GetTurnCount()>=5
end
function c100730128.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730128)
	local g=Duel.SelectMatchingCard(tp,c100730128.filter,tp,LOCATION_MZONE,0,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_BASE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(3001)
		tc:RegisterEffect(e1)
	end
end
function c100730128.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end