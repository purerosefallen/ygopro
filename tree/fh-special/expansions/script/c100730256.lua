--高速决斗技能-心灵冲突
Duel.LoadScript("speed_duel_common.lua")
function c100730256.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730256.skill,c100730256.con,aux.Stringid(100730256,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730256.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.GetMZoneCount(tp)>0
		and Duel.IsExistingMatchingCard(c100730256.filter,tp,0,LOCATION_MZONE,1,nil)
end
function c100730256.skill(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_CARD,1-tp,100730256)
	Duel.PayLPCost(tp,math.floor(Duel.GetLP(tp)/2))
	local g=Duel.SelectMatchingCard(tp,c100730256.filter,tp,0,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		Duel.GetControl(tc,tp,PHASE_END,1)
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_CANNOT_DIRECT_ATTACK)
		e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		tc:RegisterEffect(e1)
		e:Reset()
	end
end
function c100730256.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsControlerCanBeChanged()
end