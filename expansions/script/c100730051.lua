--高速决斗技能-羁绊的力量
Duel.LoadScript("speed_duel_common.lua")
function c100730051.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730051.skill,c100730051.con,aux.Stringid(100730051,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end
function c100730051.filter(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup()
end
function c100730051.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730051.filter,tp,LOCATION_MZONE,0,1,nil)
end
function c100730051.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730051)
	local g=Duel.GetMatchingGroup(c100730051.filter,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)*100
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