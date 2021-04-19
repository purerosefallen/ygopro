--高速决斗技能-调整变化：通常
Duel.LoadScript("speed_duel_common.lua")
function c100730285.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730285.skill,c100730285.con,aux.Stringid(100730285,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730285.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730285.filter,tp,LOCATION_MZONE,0,1,nil) 
end
function c100730285.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730285)
	local g=Duel.SelectMatchingCard(tp,c100730285.filter,tp,LOCATION_MZONE,0,1,3,nil)
	local tc=g:GetFirst()
	while tc do
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_ADD_TYPE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD)
		e1:SetValue(TYPE_TUNER)
		tc:RegisterEffect(e1)
		tc=g:GetNext()
	end
end
function c100730285.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_NORMAL) and not c:IsType(TYPE_TUNER)
end