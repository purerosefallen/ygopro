--高速决斗技能-科技属调整
Duel.LoadScript("speed_duel_common.lua")
function c100730284.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730284.skill,c100730284.con,aux.Stringid(100730284,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730284.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730284.filter,tp,LOCATION_MZONE,0,1,nil) 
end
function c100730284.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730284)
	local g=Duel.SelectMatchingCard(tp,c100730284.filter,tp,LOCATION_MZONE,0,1,3,nil)
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
function c100730284.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x27) and not c:IsType(TYPE_TUNER)
end