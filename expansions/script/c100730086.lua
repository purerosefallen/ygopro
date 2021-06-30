--高速决斗技能-黑暗苏生
Duel.LoadScript("speed_duel_common.lua")
function c100730086.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730086.skill,c100730086.con,aux.Stringid(100730086,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730086.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsPlayerCanSpecialSummon(tp)
		and Duel.IsExistingMatchingCard(c100730086.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,nil)
end
function c100730086.skill(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,1-tp,100730086)
	local g=Duel.SelectMatchingCard(tp,c100730086.filter,tp,LOCATION_GRAVE,LOCATION_GRAVE,1,1,nil,e,tp)
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
	local tc=g:GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,true,true,POS_FACEUP) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_NO_BATTLE_DAMAGE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e2,true)
	end
	Duel.SpecialSummonComplete()
	tc:CompleteProcedure()
	e:Reset()
end
function c100730086.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsAttackBelow(Duel.GetLP(tp)/2)
end