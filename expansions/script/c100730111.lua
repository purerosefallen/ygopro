--高速决斗技能-启示波动
Duel.LoadScript("speed_duel_common.lua")
function c100730111.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730111.skill,c100730111.con,aux.Stringid(100730111,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730111.Is8800(c)
	return c:IsType(TYPE_MONSTER) and c:IsFaceup() and c:IsAttack(c:GetDefense())
end

function c100730111.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730111.Is8800,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
end
function c100730111.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730111)
	local g=Duel.GetMatchingGroup(c100730111.Is8800,tp,LOCATION_MZONE,0,nil)
	if g:GetCount()==0 then return end
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)*300
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