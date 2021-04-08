--高速决斗技能-攻击下盘
Duel.LoadScript("speed_duel_common.lua")
function c100730252.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730252.skill,c100730252.con,aux.Stringid(100730252,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730252.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730252.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) 
end
function c100730252.skill(e,tp,eg,ep,ev,re,r,rp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730252)
	local g=Duel.SelectMatchingCard(tp,c100730252.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	local tc=g:GetFirst()
	if tc then
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
		e1:SetValue(-500)
		tc:RegisterEffect(e1)
		local e2=Effect.Clone(e1)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		tc:RegisterEffect(e2)
	end
end
function c100730252.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_MONSTER) and c:IsAttackAbove(0)
end