--高速决斗技能-力量提升！
Duel.LoadScript("speed_duel_common.lua")
function c100730274.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730274.skill,c100730274.con,aux.Stringid(100730274,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730274.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730274.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) 
end
function c100730274.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730274)
	local g=Duel.SelectMatchingCard(tp,c100730274.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(500)
		tc:RegisterEffect(e1)
	end
	local g1=Duel.SelectMatchingCard(tp,Card.IsCode,tp,LOCATION_DECK+LOCATION_GRAVE,0,0,1,nil,78211862)
	if g1:GetCount()==0 then return end
	Duel.SendtoHand(g1,tp,REASON_RULE)
end
function c100730274.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER)
end