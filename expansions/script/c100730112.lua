--高速决斗技能-最强地缚神
Duel.LoadScript("speed_duel_common.lua")
function c100730112.initial_effect(c)
	aux.SpeedDuelAtMainPhase(c,c100730112.skill,c100730112.con,aux.Stringid(100730112,0))
	aux.RegisterSpeedDuelSkillCardCommon()
end

function c100730112.Isgod(c)
	return c:IsOriginalCodeRule(41181774) and c:IsFaceup()
end

function c100730112.con(e,tp)
	tp=e:GetLabelObject():GetOwner()
	return aux.SpeedDuelAtMainPhaseCondition(e,tp)
		and Duel.IsExistingMatchingCard(c100730112.Isgod,tp,LOCATION_MZONE,0,1,nil)
		and Duel.GetMZoneCount(tp)>-1
		and Duel.GetTurnCount()>=2
end
function c100730112.skill(e,tp)
	tp=e:GetLabelObject():GetOwner()
	Duel.Hint(HINT_CARD,1-tp,100730112)
	Duel.SetLP(1-tp,1)
	Duel.SkipPhase(tp,PHASE_MAIN1,RESET_PHASE+PHASE_END,1)
	local e3=Effect.GlobalEffect()
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e3:SetTargetRange(1,0)
	e3:SetCode(EFFECT_CANNOT_BP)
	e3:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e3,tp)
	e:Reset()
end